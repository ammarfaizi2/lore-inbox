Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbSJORiz>; Tue, 15 Oct 2002 13:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbSJORiz>; Tue, 15 Oct 2002 13:38:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14246 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263277AbSJORiy>;
	Tue, 15 Oct 2002 13:38:54 -0400
Date: Tue, 15 Oct 2002 10:37:33 -0700 (PDT)
Message-Id: <20021015.103733.118756420.davem@redhat.com>
To: woockie@expressz.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42-ac1 serial compile error on sparc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1021015153934.9254A-100000@ligur.expressz.com>
References: <20021014.064142.94841093.davem@redhat.com>
	<Pine.LNX.3.96.1021015153934.9254A-100000@ligur.expressz.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IDE sparc64 systems are still not usable due to endiannes
problems in the IDE_DATA register access code.

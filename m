Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUEZFMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUEZFMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 01:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUEZFMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 01:12:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265248AbUEZFMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 01:12:44 -0400
Date: Tue, 25 May 2004 22:12:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Daney <ddaney@avtrex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -NODEV vs. -ENODEV
Message-Id: <20040525221205.2191f14f.davem@redhat.com>
In-Reply-To: <40B3DCCC.5040401@avtrex.com>
References: <40B3DCCC.5040401@avtrex.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the report, I'll fix up these 2.4.x cases.

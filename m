Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSB0AvL>; Tue, 26 Feb 2002 19:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSB0AvB>; Tue, 26 Feb 2002 19:51:01 -0500
Received: from sushi.toad.net ([162.33.130.105]:14469 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S290685AbSB0Auv>;
	Tue, 26 Feb 2002 19:50:51 -0500
Subject: Re: read_proc issue
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Laurent <laurent@augias.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 19:51:32 -0500
Message-Id: <1014771094.805.257.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't count on your proc read function being
called only once to read a given piece of information.




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280838AbRLDAqt>; Mon, 3 Dec 2001 19:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282131AbRLDAqQ>; Mon, 3 Dec 2001 19:46:16 -0500
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:29849 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282126AbRLDApL>; Mon, 3 Dec 2001 19:45:11 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan <Ethan@stinkfoot.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PPC kernel fails when IDE built as modules
Date: Tue, 4 Dec 2001 01:44:57 +0100
Message-Id: <20011204004457.6930@smtp.wanadoo.fr>
In-Reply-To: <3C0BF1C2.5070407@stinkfoot.org>
In-Reply-To: <3C0BF1C2.5070407@stinkfoot.org>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just thought I'd drop a note that recent kernel builds (2.4.17-pre1,2) 
>on PPC fail when IDE is built as modules.

The fix for this is part of the big pmac merge I'm about to start
with Marcelo. In the meantime, use the bitkeeper PPC tree
(see http://www.penguinppc.org/dev/kernel.shtml for details).

Ben.



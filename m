Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbRFCBkc>; Sat, 2 Jun 2001 21:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262720AbRFCBkV>; Sat, 2 Jun 2001 21:40:21 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:54566 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262719AbRFCBkI>; Sat, 2 Jun 2001 21:40:08 -0400
Subject: Re: USB mouse problem
From: Robert Love <rml@tech9.net>
To: Hayden "A." James <hjames@dominia.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106022120490.32178-100000@dominia.org>
In-Reply-To: <Pine.LNX.4.33.0106022120490.32178-100000@dominia.org>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 Jun 2001 21:40:08 -0400
Message-Id: <991532413.718.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Jun 2001 21:22:46 -0400, Hayden A. James wrote:
> This is a followup to my last e-mail, here is some information about my
> mouse/usb setup from dmesg.<snip>

is the mouse jerky on the console (using the mouse via GPM)?

i ask because i wager the bug is not a kernel bug but perhaps something
wrong with your X server/configuration.  i dont think there is any known
problem with the RedHat kernel, which is fairly well tested.  is there
an update for it?  since this may not be a kernel bug, you may find
better help in a RedHat or similar forum.

you could always compile your own kernel and see if that alleviates the
problem :)

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net


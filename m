Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUDTLJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUDTLJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 07:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDTLJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 07:09:06 -0400
Received: from web13901.mail.yahoo.com ([216.136.175.27]:32825 "HELO
	web13901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262380AbUDTLJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 07:09:03 -0400
Message-ID: <20040420110902.51313.qmail@web13901.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 20 Apr 2004 04:09:02 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Two problems after upgrade tto 2.4.26
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>
>after upgrading 2.4.23->2.4.26 I am seeing/heariing two problems on
>my "HP Omnibookk 6100"":
>
>a) I am getting a lot of double hits when typing (juust see this
mmail.
>I am not correecting the errors on purpose :-) While I have some
>sttupid mistyping habits, double hits all over thhe place did not
>belong to them up to now.
>

 Short update. Problem a) seems to be acpi-related. When booting with
"acpi=off", the keyboard behaves OK. 

 Not only the keyboard is affected, but also the mouse. I just did not
see it immediatelly, but with acpi enabled I am loosing pointer events.

>b)) Before the upgrade the notebook fan was rarely running at full
>speed. AAnd if, only forr short ttimes. Now it kicks in frequeently
and
>for up to 15 minutes.
>

Cheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de

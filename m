Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWBTXqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWBTXqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBTXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:46:47 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:7691 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S964853AbWBTXqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:46:46 -0500
Message-ID: <43FA54E1.5060409@tuxrocks.com>
Date: Mon, 20 Feb 2006 16:46:41 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Mozilla Thunderbird posting instructions wanted
References: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
In-Reply-To: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alexey Dobriyan wrote:
> This  POS is pretty popular among kernel janitors, so, can someone who
> is successfully using it, please, post crystally clear step-by-step
> instructions on how to send a foo.patch:
> 	inline
> 	with tabs preserved
> 	with long lines preserved
> 
> Sending plain text attachments is OK with me, but, heh, people do post
> patches inline and screw themselves.
> 
> I'll put instructions somewhere on -kj website and point every
> unsuspecting new guy to them.

Here is one method for posting patches in Thunderbird:

Before starting to write the email, do Edit->Preferences, Composition
tab, change "Wrap plain text messages at __ characters" to 0

Begin writing your email

Start up an editor in which you can select the text, for example:
# gvim patch.diff
Edit->Select All
Edit->Copy

Switch back to the open Compose window, then Edit->Paste

If you have Enigmail configured, when sending the email, you might get a
box asking if you want to change the line wrapping to 68 characters, so
just say No if that happens.


Ideally, there would be a Thunderbird plugin to insert the contents of a
file at the current location with no formatting changes...  Maybe "next
week" :)

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD+lTgaI0dwg4A47wRArxSAKCMsAj2SFckK2uPLdgTD4tHItqsHACg2eaN
nvwTg9GfO65nHahjS1MKrA4=
=0Eif
-----END PGP SIGNATURE-----

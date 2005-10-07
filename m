Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbVJGRvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbVJGRvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbVJGRvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:51:06 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:59041 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1030528AbVJGRvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:51:04 -0400
Message-ID: <4346B587.9000306@tremplin-utc.net>
Date: Fri, 07 Oct 2005 19:51:03 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.6-7mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: MTP - Media Transfer Protocol support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resent, it seems it hasn't reached the LKML on the first time)
10/06/2005 10:30 AM, Eric Piel wrote/a écrit:

>> Microsoft appearantly publishes the specifications, unfortunately for 
>> most of us it's Microsoft word format, in an executable. Would convert 
>> this for you, but I don't know how legal that is.
>>
>> http://www.microsoft.com/downloads/details.aspx?FamilyID=fed98ca6-ca7f-4e60-b88c-c5fce88f3eea&displaylang=en 
>>
> 
> Did it, nothing to agree or to sign. FWIW, the document converted to 
> PDF, only with opensource software, is available here (supprisingly, 
> inside the document it's written that it's a draft):
Deep deep apologies, I've just checked again, and in fact it seems like
yesterday I probably pressed the button without noticing I was agreeing
the license (too many "yes" buttons in my life) (or there was a nasty
bug in wine?). IANAL, so even after carefully reading it I didn't manage
to understand if it was illegal for me to read the Specification and do
a backup on my ftp server (and then give a link to it). Anyway, I've
removed it from there. I'd probably advise people who've downloaded it
to delete it.

In addition, for the ones who were interested in implementing OS support
for MTP, the points 2a and 2b seem quite frightening (also I have no
clue if what you would develop after reading the spec would
automatically become a "Licensed implementation"). Probably safer to go
back to the usual reverse engineering "daily life"... Actually there are
several free documents floating around that should make it not so
difficult anyway.

Part of the license that I've probably agreed is appended at the end of
this email. (Not everything because it seems that LKML doesn't allow me
for this)
Again, sincere apologies,
Eric Piel

---
:
:

SPECIFICATION LICENSE

The Specification is protected by copyright and other intellectual
property laws and treaties. Microsoft or its suppliers own the title,
copyright, and other intellectual property rights in the Specification.
Microsoft reserves all rights not expressly granted to you in this
agreement. The Specification is licensed, not sold.


1.  GRANT OF LICENSE.  This section of the agreement describes your
general rights to install and use the Specification.  The license rights
described in this section are subject to all other terms and conditions
of this agreement.  You may:

* install and use up to 20 copies of the Specification to design,
develop, and test your application or product that utilizes the
Specification (your "Licensed Implementation") and;
* make a reasonable number of copies of the Specification for backup and
archival purposes.


2.  LICENSE LIMITATIONS

(a)	This license does not include the right to build a Licensed
Implementation for a personal computer that implements that “Enhanced
Initiator” features, as described in the Specification.  To build such
an implementation, you must obtain a separate license from Microsoft.
Please contact WMLA@Microsoft.com to request this license.

(b)	This license does not include the right to distribute your Licensed
Implementation. In order to distribute your Licensed Implementation, you
must download the Microsoft Windows Media Transport Porting Kit and
accept its license terms.
(c)	You must not
* alter any copyright, trademark or patent notice in the Specification;
* use Microsoft’s trademarks in your Licensed Implementation’s name or
in a way that suggests your Licensed Implementation come from or are
endorsed by Microsoft;
* include the Specification in malicious, deceptive or unlawful programs; or

(d)	You may not alter any component of the Specification.

(e)	Subject to the limitation in Section 2 (a), Your Licensed
Implementation must implement the Specification in its entirety.
However, you are not required to implement any portion of the
Specification that is identified as “optional”.  If you choose to
implement a portion of the Specification that is identified as optional,
you must implement that portion in its entirety.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWG3JcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWG3JcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWG3JcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:32:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:30509 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932121AbWG3JcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:32:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VAwSo1Xu253W/grWaIkE6x0SuyKCg97jezlDGPIJMkztI8sC/BNulc0Q2cPsp8DmKzMtZjXtMkKWT3Du8h0vZpGQEVoX1T53GMReWvEDV7Do9+oqn+oDtjLgH3gCgNp+gEUzU+54PKfkCWPuD+5S3h6+6jrwTIRqpFzvqaGoVjg=
Message-ID: <44CC7CA4.3060808@gmail.com>
Date: Sun, 30 Jul 2006 11:31:57 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
References: <06ATWAN12@briare1.heliogroup.fr>
In-Reply-To: <06ATWAN12@briare1.heliogroup.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau wrote:
> Greg KH wrote:
>> On Sun, Jul 30, 2006 at 12:21:13PM  0000, Hubert Tonneau wrote:
>>> Off topic information:
>>> With 2.6.17, none of my USB sound cards works; all of them work with 2.6.16
>> That's not good at all.  Care to run 'git bisect' on the tree to find
>> out what patch caused it?
> 
> Hard to do since I'm not a git user.

Then, could you "bisect" it just by -17-rcX patches applying and testing?

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

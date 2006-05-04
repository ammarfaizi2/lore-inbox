Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWEDVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWEDVoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEDVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:44:31 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:10795 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751505AbWEDVoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:44:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pZ4/x1Ul5edoFTu1wnIJ1Cv7urGmnkD3OwDS/zSoCg3ex/JjWu9W2x89ea/WegBVC97EOXYfi32/fccFYZTgwGmfZ4BQvhZVvIL/mizMNLsP49OGr3BUsoGG+z9iCTT6iJp5Jh7yGZsv3TsdrHu396BCAEbcqh9F6je+tiVZgdg=
Message-ID: <445A75AD.7090105@gmail.com>
Date: Fri, 05 May 2006 05:44:13 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: framebuffer broken in 2.6.16.x and 2.6.17-rc3 ?
References: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com> <gs7iuaocrzmp.s33e3qhm21bl.dlg@40tude.net> <445A68AC.3090207@gmail.com> <1vsfcg3epbb29.t96cunohji42$.dlg@40tude.net>
In-Reply-To: <1vsfcg3epbb29.t96cunohji42$.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Fri, 05 May 2006 04:48:44 +0800, Antonino A. Daplas wrote:
> 
>> Giuseppe Bilotta wrote:
>>> On Tue, 2 May 2006 21:51:13 +0200, Olivier Fourdan wrote:
>>>
>>> I don't know what method he used to upgrade his kernel, but the setting
>> changed from 'y' to 'm', and I've received quite a few reports from
>> different users on this lately...
> 
> Well, when it happened to me it was because I switched from a distro
> kernel to a custom build and so the error was entirely on my part. I
> still think that some kind of warning in the dmesg or appropriate
> wording in the help for the framebuffer devices or for fbcon would
> help sort this FAQ out.

This is already documented in Documentation/fb/fbcon.txt. Although a
warning in the help text of vesafb might help.

Tony

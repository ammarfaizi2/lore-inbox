Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313760AbSEAR6I>; Wed, 1 May 2002 13:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313765AbSEAR6H>; Wed, 1 May 2002 13:58:07 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:19625 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313760AbSEAR6F>; Wed, 1 May 2002 13:58:05 -0400
Message-ID: <3CD02C60.3030004@wanadoo.fr>
Date: Wed, 01 May 2002 19:56:48 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob_Tracy <rct@gherkin.frus.com>
CC: system_lists@nullzone.org, linux-kernel@vger.kernel.org
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
In-Reply-To: <m172xYI-0005khC@gherkin.frus.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob_Tracy wrote:
> Confirmed on a 2.5.11 system as well.  Talk about your basic heart
> attack!  I'd just installed Postfix and found that I couldn't access
> any of the directories under /var/spool/postfix.  Fortunately (?),
> I've got older kernels to fall back on, and that's one of the hazards
> of running on the bleeding edge I reckon.
> 
> Oh yeah...  ext2 filesystem.  I think this bug is at least mostly
> independent of the filesystem type.

The same here with 2.5.12 and ext2, have you run fsck on this  fs ?


Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------


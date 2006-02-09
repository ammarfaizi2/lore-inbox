Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422908AbWBIOAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWBIOAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWBIOAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:00:07 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:62090 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1422908AbWBIOAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:00:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yAyspFpobiJPCaOnT2ECVpsk0JQFtKc9MsZV4jAFWVs2aWXF9bg3NJ9HKQsioD7TDdls07/3fILQ2uqehAaZgWcQEPxx8Nofel8kncwfRDvxPjLW7iyWX5lWe7vAqffkwU/RVbHhNPq56fFTn3B1wdnKwQlp0BEm+0g8ywhPZxk=  ;
Message-ID: <43EB4AE6.2090808@yahoo.com.au>
Date: Fri, 10 Feb 2006 01:00:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <20060209104115.GA15173@merlin.emma.line.org> <43EB450D.nail972311S71@burner>
In-Reply-To: <43EB450D.nail972311S71@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> 
>>This all only matters to you since you are trying to enforce the botched
>>view from some other OS (MS-Windows perhaps, although I'm not too sure
>>if it's really Windows or Jörg Schilling who is the problem in this
>>scenario either, and I'm a long way from defending Microsoft) onto
>>Linux, which you have been denied for 1½ years now, and from what I've
>>seen this year, with good reason.
> 
> 
> You look confused. It is not me but the Linux maintainers refuse to fix
> bugs since about 2 years.
> 

Regardless of whether you consider it a bug or the naming wrong[1], you
are not the Linux maintainer and Linux users have to put up with their
choices of kernel architecture.

So introducing your own naming scheme AFAIKS only serves to add more
confusion to the picture -- it seems fairly unlikely that you'll get the
kernel guys to change their minds.

Goes along the same lines as my point about filesystem naming. I wouldn't
write a portable program that asks users to save their files on /dev/hda
or /c_drive/blah when on windows. I'd agree to disagree with wnidows, and
use C:\ for the sake of everyone's sanity.

[1] I don't want to argue *that* point with you and I don't pretend
to know more about it than you or anyone else on this thread.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

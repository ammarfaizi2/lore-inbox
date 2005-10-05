Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVJEToe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVJEToe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbVJEToe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:44:34 -0400
Received: from 10.ctyme.com ([69.50.231.10]:1951 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1030348AbVJETo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:44:27 -0400
Message-ID: <43442D19.4050005@perkel.com>
Date: Wed, 05 Oct 2005 12:44:25 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florin Malita <fmalita@gmail.com>
CC: lsorense@csclub.uwaterloo.ca, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it>	<4U0XH-3Gp-39@gated-at.bofh.it>	<E1EMutG-0001Hd-7U@be1.lrz>	<87k6gsjalu.fsf@amaterasu.srvr.nix>	<4343E611.1000901@perkel.com>	<20051005144441.GC8011@csclub.uwaterloo.ca>	<4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com>
In-Reply-To: <20051005153727.994c4709.fmalita@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Florin Malita wrote:

>On Wed, 05 Oct 2005 07:48:12 -0700
>Marc Perkel <marc@perkel.com> wrote:
>  
>
>>What is incredibly idiotic is a file system that allws you to delete 
>>files that you have no write access to. That is stupid beyond belief and 
>>only the Unix community doesn't get it.
>>    
>>
>
>It stops being idiotic as soon as you realize that _deleting_ a
>file doesn't involve _writing_ to it in any way. It's not about UNIX,
>it's about common sense - try thinking outside of the Netware box for a
>sec ;)
>
>Florin
>  
>
What you don't get is that if you don't have rights to write to a file 
then you shouldn't have the right to delete the file.  Once you get past 
the "inside the box" Unix thinking you'll see the logic in this. So what 
if the process of deleting a file involves writing to it. That's not 
relevant.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com


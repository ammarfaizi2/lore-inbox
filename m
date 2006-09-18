Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWIRVl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWIRVl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWIRVl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:41:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:55163 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751934AbWIRVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:41:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6CTSP94mCR4RwV4FlCuw9sd6DAtskvCAQyIHDredTTSHatmu5ztEIIF6YMdfC+Wz9jL87V4OCXI5l8cacGzz/yssW93YJX4IEC8A/UK/VoVrRXExpFf8b8jB7PaYi94P0Gtue79HzUC1jM0Stjq8a5Wvhm2T7c06p1NSyFgebA=
Message-ID: <9a8748490609181441w3741621do2d161567ca390373@mail.gmail.com>
Date: Mon, 18 Sep 2006 23:41:26 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Anuj Tripathi" <anujt@it.iitb.ac.in>
Subject: Re: Problems in compiling the module "/net/ieee80211"
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <450F0515.3040002@it.iitb.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <450F0515.3040002@it.iitb.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/06, Anuj Tripathi <anujt@it.iitb.ac.in> wrote:
> Hi
>
> I am trying to compile the kernel source code of .c files in
> /linux-2.6.17.11/net/ieee80211 in  a standalone manner.

What's wrong with :

$ make allyesconfig
$ make net/ieee80211/

 ???

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

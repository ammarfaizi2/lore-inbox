Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWG1I4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWG1I4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWG1I4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:56:33 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:4064 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932587AbWG1I4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:56:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gqDDCRFOfXSeYLEZQKayLyA19HXuT/0oixjbg8rzln8yOwaOOiTR4MKg5WYwpWyluXvOIAKlqfYb5JqhTFgaXKTG5nF6fMrDziQpK9Vpb6dsP3yESNavJ+3PLHrMSu9YxGEs2imdEdNcsM5Di6WVrTWtG+8SuR9KHOJ8g/hemBw=
Message-ID: <6bffcb0e0607280156s7a6c64eem8849c7d488964b82@mail.gmail.com>
Date: Fri, 28 Jul 2006 10:56:32 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc2-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727015639.9c89db57.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
>
[snip]
> - Semi-daily snapshots of the -mm lineup are uploaded to
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
>   the mm-commits list.

Andrew, have you considered switching that tree to git? IMHO
git-bisect is a killer-app.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

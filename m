Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbVKIHA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbVKIHA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVKIHA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:00:57 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:63907 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965227AbVKIHA5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:00:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=aNTM6iwSJYArof7H2s4jxrMEkRUitngAnevhXuSNseAFKlofBZVHQWpe/9L8txLNsDIHDeP1LtGEGg5JxYM74ZDLJY2OihD8WU+cV1pXQnj36QNtnKqA2NOGFP48Xy66zgZVIyDYDKLOIfiayTfQA2fYvS0gUyEC76LJzDoXvKw=
Date: Wed, 9 Nov 2005 08:00:39 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: caszonyi@rdslink.ro, jerome.lacoste@gmail.com, hostmaster@ed-soft.at,
       linux-kernel@vger.kernel.org
Subject: Re: New Linux Development Model
Message-Id: <20051109080039.7cef0d61.diegocg@gmail.com>
In-Reply-To: <200511091123.52092.kernel@kolivas.org>
References: <436C7E77.3080601@ed-soft.at>
	<5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
	<Pine.LNX.4.62.0511090202030.2383@grinch.ro>
	<200511091123.52092.kernel@kolivas.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 9 Nov 2005 11:23:51 +1100,
Con Kolivas <kernel@kolivas.org> escribió:

> Eh? Where are the bug reports for this? I've only seen better interactivity 
> and responsiveness with 2.6. 

It has certainly much better behaviour under load for me, to the point 
that sometimes I don't notice there's some computing-intensive process
running in the background until I run top (and i thank you a lot for
that ;)

Diego Calleja (who had lots of VM problems and suffered from filesystem
corruption two times with 2.4 and its "stable" development model)

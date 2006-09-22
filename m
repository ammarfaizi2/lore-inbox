Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWIVVST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWIVVST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWIVVST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:18:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:58820 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932163AbWIVVSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:18:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=joNQJauDoyEuHpVh9JDkuFy2eCeFR6RDtryLnySmBpopP1/jsTZbwzYa1lTbZ18UbaQ0tHN1NyAtWh0LQEJE9rX/rP4z75JgoAC9XrEdOCtwSYbhkkowYIEUbvsg+zkcxFphuorNw1FYcFbdqIZQHb1L8NQ+l+keSf5U32HORlg=
Message-ID: <acd2a5930609221418n7fd1251do636f56828a275505@mail.gmail.com>
Date: Sat, 23 Sep 2006 01:18:17 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Cc: pavel@ucw.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200609222028.k8MKSN5h008476@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609222028.k8MKSN5h008476@olwen.urbana.css.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/06, Scott E. Preece <preece@motorola.com> wrote:
>
> I've been hoping somebody would send a good description of exactly what
> they mean by "power domain" or "voltage domain", so we could talk about
> it...

I understand it as an arbitrary set of devices grouped according to a
certain rule. An operating point will then deal with set of power
domains not with set of devices.

Vitaly

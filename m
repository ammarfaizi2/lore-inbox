Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVLQMjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVLQMjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 07:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVLQMi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 07:38:59 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:8367 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932572AbVLQMi7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 07:38:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GZyR9WPAZBl+1YMyhnj/g20ftVc01WHSBzTzmw9ZydMA8uO9P3dGqXvLLiyL9roag6Zh2ioPdE+kvbNNh54rtrG58/Kv48aD7lLHZTsLceDML9UxABGc6NvK5bI3WcGjBQ+lOwMLdFDuPm2s/v5NtPyRg4xBF5wuaT7IASIJPX8=
Message-ID: <84144f020512170438p5acbc445v30f275aca2d09afe@mail.gmail.com>
Date: Sat, 17 Dec 2005 14:38:57 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH 03/13] [RFC] ipath copy routines
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <200512161548.lRw6KI369ooIXS9o@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	 <200512161548.lRw6KI369ooIXS9o@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/05, Roland Dreier <rolandd@cisco.com> wrote:
> +#define TRUE 1
> +#define FALSE 0

Please kill these.

                             Pekka

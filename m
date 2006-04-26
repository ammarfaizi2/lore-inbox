Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWDZQWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWDZQWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWDZQWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:22:16 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:51622 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964802AbWDZQWQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aeMRHElkbcMARVYX7abh44ikuqVaDKj7/rzIVDxdOcq2iEN88eJ6LdhPykeAoz2WPZtw/j4nTl6qyfFUj+52z/vGxLfJrR7QOokbLTqWjoqrG9QB7RdS1lYyuczr3NMVYxvgAz88VkRbrUemwLXjeGubFByMhB2MA7rbwEvBXuw=
Message-ID: <2f4958ff0604260922l6441d6c1s72d327c0f0ff2318@mail.gmail.com>
Date: Wed, 26 Apr 2006 18:22:14 +0200
From: "=?ISO-8859-2?Q?Grzegorz_Ja=B6kiewicz?=" <gryzman@gmail.com>
To: "Ioan Ionita" <opslynx@gmail.com>
Subject: Re: can't compile kernels lately (2.6.16.5 and up)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <df47b87a0604260906m519cc6f5ud4d8527d4e5a243e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
	 <200604261102.12935.gene.heskett@verizon.net>
	 <2f4958ff0604260817l68235c77hb3430b2a800a96cf@mail.gmail.com>
	 <df47b87a0604260906m519cc6f5ud4d8527d4e5a243e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/06, Ioan Ionita <opslynx@gmail.com> wrote:
> Try again with a fresh complete tree.
> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.11.tar.bz2

that did the job, but I guess patches are provided for one and only
reason - so I will not have to download over and over again big pile
of bzipped source from the server. So you say patch is fscked up ?

--
GJ

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWA3JnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWA3JnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWA3JnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:43:09 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:54551 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932168AbWA3JnI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:43:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uJvmYS/P2yQaohkRXXqd4t/Bn4tMRSr2HIMMt9EuT4/VkP4kIFk6h0bF5LBI3SxyIclZZhM9+af8JSvWvVhK1XovCIZmvWfvUvKwBqqU5L8THcMzEIS2Ar/y6T/YVOv+pYUPh8iryMUriwA/9NnRIObQlBVA+VgA1U5r0cQOcbQ=
Message-ID: <aed62bae0601300143p3354c40aq9240db51e6e289ad@mail.gmail.com>
Date: Mon, 30 Jan 2006 15:13:07 +0530
From: sarat <saratkumar.koduri@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: insmod error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1138611030.2977.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aed62bae0601292023l641fb644k870a2b1b099e6dc3@mail.gmail.com>
	 <1e62d1370601292104s3e8ad2bcx2d67e626cac04c8a@mail.gmail.com>
	 <aed62bae0601292111s38714b3bsd2c58abc83188aea@mail.gmail.com>
	 <1138611030.2977.2.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay.... i got you but the thing is i dn't know exactly how to convert
the code.. can any body plz help me..

On 1/30/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-01-30 at 10:41 +0530, sarat wrote:
> > this is the error given in 'dmesg' hope this is okay..
> > firewall: module license 'unspecified' taints kernel.
> > firewall: Unknown symbol register_firewall
> > firewall: Unknown symbol unregister_firewall
>
>
> same question as was asked last week. This module is not compatible with
> 2.6.10 and later, and needs rewriting to be compliant with the 2.4/2.6
> firewall (as opposed to the 2.2 kernel firewall).
>
>
>


--
ur's sarat

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWBZM7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWBZM7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBZM7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:59:37 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:64995 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751093AbWBZM7g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:59:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=an3T0j4xeHytyZ1PKdeBI2WiCRZexne4ISv1a9upgGyeAwYJ9C1dK+c2iJYOnfA7SUxFQDae2KEp3ehui8qUclp9IvneVekvXDbB+EvHIJ+FugGSJRI6eV2gdFn6mc8SqUmVS9RQjZ4Q5XcMgpcmO4Pd/IRvjQWLQT+Mk8S2l5k=
Message-ID: <9a8748490602260459j76409f0cu287d7efad4d1781c@mail.gmail.com>
Date: Sun, 26 Feb 2006 13:59:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: rol@as2917.net
Subject: Re: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux.nics@intel.com,
       cramerj@intel.com, john.ronciak@intel.com, Ganesh.Venkatesan@intel.com
In-Reply-To: <007801c639f3$79388060$2001a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060225085409.GA22456@infradead.org>
	 <007801c639f3$79388060$2001a8c0@cortex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Paul Rolland <rol@as2917.net> wrote:
> Hello,
>
> This patch is based on Linux 2.4.32, and I've verified the same problem
> exists on 2.6.15.4.

are you planning a 2.6 patch as well ?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

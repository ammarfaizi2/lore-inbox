Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbTABQjy>; Thu, 2 Jan 2003 11:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTABQjx>; Thu, 2 Jan 2003 11:39:53 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:26383 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264969AbTABQjx>; Thu, 2 Jan 2003 11:39:53 -0500
Date: Thu, 2 Jan 2003 16:48:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Loic Jaquemet <jaquemet@fiifo.u-psud.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.54 I2C drivers/media update..
Message-ID: <20030102164822.A25818@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Loic Jaquemet <jaquemet@fiifo.u-psud.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3E146967.E8DC4941@fiifo.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E146967.E8DC4941@fiifo.u-psud.fr>; from jaquemet@fiifo.u-psud.fr on Thu, Jan 02, 2003 at 04:31:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:31:35PM +0000, Loic Jaquemet wrote:
> 
> struct i2c_driver has changed .

Once you're at it you could convert them to named initializer :)


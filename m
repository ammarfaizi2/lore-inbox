Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271997AbSISRbG>; Thu, 19 Sep 2002 13:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272056AbSISRbG>; Thu, 19 Sep 2002 13:31:06 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:2319 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S271997AbSISRbG>; Thu, 19 Sep 2002 13:31:06 -0400
Date: Thu, 19 Sep 2002 18:36:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac3
Message-ID: <20020919183609.A7909@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200209191728.g8JHSBg22827@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209191728.g8JHSBg22827@devserv.devel.redhat.com>; from alan@redhat.com on Thu, Sep 19, 2002 at 01:28:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 01:28:11PM -0400, Alan Cox wrote:
>  [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out, - indicates stuff not relevant to the main tree]
> 
> **	I still need to sort out the JFS cond_resched

Just take cond_resched from 2.4/2.5 mainline..


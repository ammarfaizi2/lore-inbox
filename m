Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVHXQDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVHXQDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVHXQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:03:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18591 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751101AbVHXQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:03:41 -0400
Subject: Re: VIA Rhine ethernet driver bug (reprise...)
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <1124898624.3855.3.camel@mindpipe>
References: <430A0B69.1060304@xs4all.nl>
	 <200508231221.59299.vda@ilport.com.ua>  <1124898624.3855.3.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 12:03:38 -0400
Message-Id: <1124899419.3855.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 11:50 -0400, Lee Revell wrote:
> On Tue, 2005-08-23 at 12:21 +0300, Denis Vlasenko wrote:
> > My suggestion was, and still is:


Never mind, I misread the original post.  This workaround is probably OK
if you only do the reset when this error condition arises.

Lee


Return-Path: <linux-kernel-owner+w=401wt.eu-S1751440AbXAKVCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbXAKVCz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAKVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:02:55 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:47987 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbXAKVCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:02:55 -0500
Subject: Re: [FYI] Vendor interest in Unionfs
From: Ben Collins <ben.collins@ubuntu.com>
To: Indrek Kruusa <indrek.kruusa@artecdesign.ee>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <45A37D73.1090604@artecdesign.ee>
References: <45A37D73.1090604@artecdesign.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Jan 2007 16:02:49 -0500
Message-Id: <1168549369.5332.5.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 13:33 +0200, Indrek Kruusa wrote:
>  >> Is there vendor interest in unionfs?
> 
>  > MANY live cds seem to use it
> 
> 
> I'd like to add that also in embedded area (flash storage) the UnionFS 
> helps in some cases.

I'll chime in as well. Ubuntu uses unionfs extensively for our live
CD's. I'd very much like to stop adding this to our kernels myself.

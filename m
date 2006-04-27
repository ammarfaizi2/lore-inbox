Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWD0Nm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWD0Nm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWD0Nm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:42:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:43284 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965050AbWD0Nmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:42:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R22cll51n1z96KUasM59zUBGWfZb/TEmaidgT+GmBESGEqgjg91Z+bvPCaDVYPJ8YcWq7rOLP9c22ky9nhQpvhYPHqY7V9E54hYlX6EfLAL6cJo3zt3gBKBQpUmoiJ0uHtKijO7e9qO17aNXwN4EGXPycCtmNQDewN/UbYCQPo8=
Message-ID: <84144f020604270642j788be2ecp82841ac3b3ebcaad@mail.gmail.com>
Date: Thu, 27 Apr 2006 16:42:52 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
Cc: "Heiko J Schick" <schihei@de.ibm.com>, openib-general@openib.org,
       "Christoph Raisch" <RAISCH@de.ibm.com>,
       "Hoang-Nam Nguyen" <HNGUYEN@de.ibm.com>,
       "Marcus Eder" <MEDER@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20060427123701.GG32127@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4450A1C0.3080209@de.ibm.com>
	 <20060427123701.GG32127@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> The whole patch is full of parameter-happy functions with this one
> being the ugly top of the iceberg.  I sincerely hope this is not a
> defined ABI and can still be changed.

It's not in mainline, so it can be changed.

                                                Pekka

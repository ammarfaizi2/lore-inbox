Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTFXHr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 03:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFXHr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 03:47:29 -0400
Received: from [62.29.78.164] ([62.29.78.164]:35971 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262273AbTFXHr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 03:47:28 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.73-mm1
Date: Tue, 24 Jun 2003 11:02:22 +0300
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030623232908.036a1bd2.akpm@digeo.com> <200306241045.15886.kde@myrealbox.com> <20030624005720.06b2d3d0.akpm@digeo.com>
In-Reply-To: <20030624005720.06b2d3d0.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-1=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306241102.22667.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 June 2003 10:57, Andrew Morton wrote:
> The configurable PAGE_OFFSET patch seems to confuse the build system
> sometimes.
>
> Do another `make oldconfig', that should flush it out.
Doing make menuconfig->exit->save fixed it. 

Regards,
/ismail

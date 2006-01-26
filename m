Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWAZA6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWAZA6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWAZA6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:58:38 -0500
Received: from amdext4.amd.com ([163.181.251.6]:11136 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932244AbWAZA6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:58:37 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Wed, 25 Jan 2006 18:58:10 -0600
User-Agent: KMail/1.8
cc: "Robin Holt" <holt@sgi.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601251648.58670.raybry@mpdtxmail.amd.com>
 <F6EF7D7093D441B7655A8755@[10.1.1.4]>
In-Reply-To: <F6EF7D7093D441B7655A8755@[10.1.1.4]>
MIME-Version: 1.0
Message-ID: <200601251858.11167.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 26 Jan 2006 00:58:12.0912 (UTC)
 FILETIME=[952D1300:01C62213]
X-WSS-ID: 6FC6C12F0MS657390-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Hmph.... further analysis shows that the situation is a more complicated than 
described in my last note, lets compare notes off-list and see what 
conclusions, if any, we can come to.

Thanks,
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)


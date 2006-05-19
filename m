Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWESQzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWESQzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWESQzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:55:42 -0400
Received: from amdext4.amd.com ([163.181.251.6]:1741 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751353AbWESQzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:55:42 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
Date: Fri, 19 May 2006 11:55:17 -0500
User-Agent: KMail/1.8
cc: "Hugh Dickins" <hugh@veritas.com>,
       "Linux Memory Management" <linux-mm@kvack.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <1146671004.24422.20.camel@wildcat.int.mccr.org>
 <200605081432.40287.raybry@mpdtxmail.amd.com>
 <2F9DB20EAB953ECFD816E9BF@[10.1.1.4]>
In-Reply-To: <2F9DB20EAB953ECFD816E9BF@[10.1.1.4]>
MIME-Version: 1.0
Message-ID: <200605191155.17880.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 19 May 2006 16:56:31.0939 (UTC)
 FILETIME=[2DF21130:01C67B65]
X-WSS-ID: 6873273540W426099-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 16:09, Dave McCracken wrote:
> --On Monday, May 08, 2006 14:32:39 -0500 Ray Bryant
>
> <raybry@mpdtxmail.amd.com> wrote:
> > On Saturday 06 May 2006 10:25, Hugh Dickins wrote:
> > <snip>
> >
> >> How was Ray Bryant's shared,anonymous,fork,munmap,private bug of
> >> 25 Jan resolved?  We didn't hear the end of that.
> >
> > I never heard anything back from Dave, either.
>
> My apologies.  As I recall your problem looked to be a race in an area
> where I was redoing the concurrency control.  I intended to ask you to
> retest when my new version came out.  Unfortunately the new version took
> awhile, and by the time I sent it out I forgot to ask you about it.
>
> I believe your problem should be fixed in recent versions.  If not, I'll
> make another pass at it.
>
> Dave McCracken
>

Let me build up a kernel with the latest patches and give it a try.   
(Sorry for delay, didn't see this note until today.)

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)


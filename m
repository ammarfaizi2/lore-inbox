Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287899AbSAHFwI>; Tue, 8 Jan 2002 00:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287915AbSAHFv7>; Tue, 8 Jan 2002 00:51:59 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:20379 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287899AbSAHFvk>; Tue, 8 Jan 2002 00:51:40 -0500
Date: Tue, 8 Jan 2002 00:51:25 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [orphan patch] 2.5.2-pre9 Assign syscall numbers for testing
Message-ID: <20020108005125.D7376@redhat.com>
In-Reply-To: <4052.1010458221@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4052.1010458221@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jan 08, 2002 at 01:50:21PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 01:50:21PM +1100, Keith Owens wrote:
> I have sent this patch to Linus twice and got no reply.  I don't have
> time to maintain it, this is now an orphan patch.  If anybody wants it,
> they can have it.

Do NOT apply this patch, it breaks forward compatibility assumptions.

		-ben

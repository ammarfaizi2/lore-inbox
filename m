Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTDNRkq (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTDNRkq (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:40:46 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:14219 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S263586AbTDNRko (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:40:44 -0400
Date: Mon, 14 Apr 2003 10:51:42 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] kdevt-diff
Message-ID: <20030414175141.GS4917@ca-server1.us.oracle.com>
References: <UTC200304132245.h3DMjaT25518.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304132245.h3DMjaT25518.aeb@smtp.cwi.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 12:45:36AM +0200, Andries.Brouwer@cwi.nl wrote:
> The structure here is 8+8, except when more bits are
> present, in which case it is 16+16, except when more bits
> are present, in which case it is 32+32.

	Why complicate things?  Is it that bad?  We'd all have to know
about the mess when dealing with userspace.

Joel

-- 

Life's Little Instruction Book #237

	"Seek out the good in people."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

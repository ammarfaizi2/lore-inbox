Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265376AbUEZJ2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUEZJ2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUEZJ2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:28:09 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9344 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265376AbUEZJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:28:07 -0400
Date: Wed, 26 May 2004 10:34:37 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Buddy Lumpkin <b.lumpkin@comcast.net>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <40B4590A.1090006@yahoo.com.au>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
 <40B4590A.1090006@yahoo.com.au>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> Even for systems that don't *need* the extra memory space, swap can
> actually provide performance improvements by allowing unused memory
> to be replaced with often-used memory.

That's true, but it's not a magical property of swap space - extra physical
RAM would do more or less the same thing.

John.

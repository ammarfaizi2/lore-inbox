Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTEGLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 07:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTEGLx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 07:53:57 -0400
Received: from holomorphy.com ([66.224.33.161]:58766 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263131AbTEGLx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 07:53:56 -0400
Date: Wed, 7 May 2003 05:06:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030507120624.GZ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030506232326.7e7237ac.akpm@digeo.com> <3EB8DBA0.7020305@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB8DBA0.7020305@aitel.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 12:10:40PM +0200, Helge Hafting wrote:
> 2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
> light load.

Could you try testing with the slabification patch backed out?

Thanks.


-- wli

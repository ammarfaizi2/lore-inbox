Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267325AbTABXqG>; Thu, 2 Jan 2003 18:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267326AbTABXqG>; Thu, 2 Jan 2003 18:46:06 -0500
Received: from holomorphy.com ([66.224.33.161]:42694 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267325AbTABXqE>;
	Thu, 2 Jan 2003 18:46:04 -0500
Date: Thu, 2 Jan 2003 15:54:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
       linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Questton about Zone Allocation 2.4.X
Message-ID: <20030102235425.GT9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102235147.GS9704@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 03:51:47PM -0800, William Lee Irwin III wrote:
> __get_free_pages() allocates from lowmem (i.e. 0-4GB) only.
> Allocate from highmem instead.

0-1GB only.


Bill

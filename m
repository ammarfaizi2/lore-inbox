Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315211AbSECTKF>; Fri, 3 May 2002 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315658AbSECTKE>; Fri, 3 May 2002 15:10:04 -0400
Received: from imladris.infradead.org ([194.205.184.45]:15113 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315211AbSECTKE>; Fri, 3 May 2002 15:10:04 -0400
Date: Fri, 3 May 2002 20:09:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Tony Luck <aegl@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503200958.A30548@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Tony Luck <aegl@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020503183701.32163.qmail@web13505.mail.yahoo.com> <Pine.LNX.3.95.1020503144728.8291A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 03:01:48PM -0400, Richard B. Johnson wrote:
> The other Unix's I've become familiar are Sun-OS, the

SunOS 5 uses separate address spaces on sparcv9 (32 and 64bit).
The same is true for many Linux ports, e.g. sparc64 or s390.

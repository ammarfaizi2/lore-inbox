Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRDEXNT>; Thu, 5 Apr 2001 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRDEXNK>; Thu, 5 Apr 2001 19:13:10 -0400
Received: from mailb.telia.com ([194.22.194.6]:33541 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S129478AbRDEXMv>;
	Thu, 5 Apr 2001 19:12:51 -0400
Date: Fri, 6 Apr 2001 01:13:02 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <anedah-9@sm.luth.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 3 kmalloc underallocation bugs
Message-ID: <20010406011301.A11046@sm.luth.se>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200104052245.PAA29663@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104052245.PAA29663@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Thu, Apr 05, 2001 at 03:45:47PM -0700
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.Stanford.EDU> wrote:
> enclosed are three bugs found in the 2.4.1 kernel by an extension

Why are you guys running these tests against an already old kernel?
I would suggest running it against at least Linus' latest version, or
preferably Alan's -ac tree.
-- 

André Dahlqvist <anedah-9@sm.luth.se>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289050AbSAZKYV>; Sat, 26 Jan 2002 05:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbSAZKYK>; Sat, 26 Jan 2002 05:24:10 -0500
Received: from tapu.cryptoapps.com ([63.108.153.39]:44985 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S289050AbSAZKX5>;
	Sat, 26 Jan 2002 05:23:57 -0500
Date: Sat, 26 Jan 2002 02:22:53 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020126102253.GD4276@tapu.f00f.org>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com> <20020124223325.GA886@tapu.f00f.org> <a2q2oj$jk$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2q2oj$jk$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.26i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 02:44:35PM -0800, H. Peter Anvin wrote:

    Try inserting a compilation unit or other hard optimization
    boundary.

Can you provide and example please?

My trivial test comparing "int i, if (i)" verses "bool t, if (t)"
shows the exact same code is produced --- what should I be looking at
here?




  --cw


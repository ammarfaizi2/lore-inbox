Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUDEQHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDEQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:07:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27396 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262909AbUDEQHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:07:19 -0400
Message-ID: <40718404.8020802@zytor.com>
Date: Mon, 05 Apr 2004 09:06:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: DXpublica@telefonica.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [kernel.org] md5 for verifying downloads of kernel [right post]
References: <200404051533.05155.DXpublica@telefonica.net>
In-Reply-To: <200404051533.05155.DXpublica@telefonica.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xan wrote:
> Is it possible to put in webpage and in ftp a link and a file, respectively, 
> of the md5 sums (or any other checking file program) of all kernel files?. 
> With this, anyone could see if the downloaded kernel file (usually more than 
> 30MB) is well-downloaded.
> 
> Thanks,
> Xan.
> 
> PS: I believe that one good place to put link were after cset link. That is, 
> the lines of kernel.org were as:
> 
> [...]   2.6.4   2004-03-11 03:16 
> UTC    F       V       VI      C       MD5     Changelog
> 

Look for .sign files.

	-hpa


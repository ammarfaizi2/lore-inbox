Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315506AbSEHDW2>; Tue, 7 May 2002 23:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315507AbSEHDW1>; Tue, 7 May 2002 23:22:27 -0400
Received: from florence.ie.alphyra.com ([193.120.224.170]:33418 "EHLO
	florence.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S315506AbSEHDW0>; Tue, 7 May 2002 23:22:26 -0400
Date: Wed, 8 May 2002 04:22:11 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
In-Reply-To: <Pine.LNX.3.95.1020507104428.7036A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0205080421280.16371-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Richard B. Johnson wrote:

> This procedure is called from numerous places in the code.
> In line 1069 of eepro100.c, comment out the call to wait_for_cmd_done().
> See if this fixes it. 

server started showing same problem again and, nope... this doesnt fix 
it for me.

:(

--paulj


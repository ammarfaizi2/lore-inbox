Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUDPQUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUDPQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:20:31 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:11393
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263307AbUDPQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:20:26 -0400
Subject: Re: nfs 2 over udp file corruption
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: PasTresBeau <pastresbeau@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <407FCF89.6070305@free.fr>
References: <407FCF89.6070305@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082132424.2581.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 09:20:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 05:20, PasTresBeau wrote:
> Hi,
> 
> I have the following strange behavior:
> 
> Copying a file over a nfs v2-udp mount
> gets the file corrupted.. the command
> exits saying "mv: closing <my_filename>: IO Error"

Are you using the "soft" mount option?

Cheers,
  Trond

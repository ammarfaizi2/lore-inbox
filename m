Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTIYWFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 18:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbTIYWFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 18:05:24 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:11210 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261931AbTIYWFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 18:05:21 -0400
Date: Fri, 26 Sep 2003 00:05:19 +0200 (CEST)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
X-X-Sender: donald@duck.sh.cvut.cz
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB/VISOR module
In-Reply-To: <20030925211434.GC29680@kroah.com>
Message-ID: <Pine.LNX.4.58.0309260002140.26074@duck.sh.cvut.cz>
References: <Pine.LNX.4.58.0309251218460.24867@duck.sh.cvut.cz>
 <20030925211434.GC29680@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Greg KH wrote:
# Why are you trying to attach to port 0?  What happens with:
# 	pilot-xfer -p /dev/ttyUSB1 -l

   The same thing. I've already tried that before.
   - M -

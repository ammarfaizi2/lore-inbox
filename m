Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVITHbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVITHbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVITHbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:31:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64141 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964899AbVITHbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:31:45 -0400
Date: Tue, 20 Sep 2005 08:31:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: Re: [RFC PATCH 8/10] vfs: shared subtree aware namespaces
Message-ID: <20050920073144.GK7992@ftp.linux.org.uk>
References: <20050916182620.GA28532@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182620.GA28532@RAM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:20AM -0700, Ram wrote:
> Patch that help setup the correct propagation for the mounts under the new
> cloned namespace.

_definitely_ should go earlier in the series.

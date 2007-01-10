Return-Path: <linux-kernel-owner+w=401wt.eu-S932769AbXAJMCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXAJMCQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 07:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbXAJMCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 07:02:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49146 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469AbXAJMCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 07:02:15 -0500
Date: Wed, 10 Jan 2007 12:02:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: [PATCH 1 of 2]: Make BH_Unwritten a first class bufferhead flag V2
Message-ID: <20070110120213.GA28534@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Chinner <dgc@sgi.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, xfs@oss.sgi.com
References: <20070110003354.GN44411608@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110003354.GN44411608@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two patches look good to me.


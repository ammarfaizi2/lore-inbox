Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTFMGcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbTFMGcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:32:22 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:9744 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265172AbTFMGcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:32:22 -0400
Date: Fri, 13 Jun 2003 07:46:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.5.70: Export set_fs_root and set_fs_pwd
Message-ID: <20030613074607.A5830@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. J. Lu" <hjl@lucon.org>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20030613054228.GA27470@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030613054228.GA27470@lucon.org>; from hjl@lucon.org on Thu, Jun 12, 2003 at 10:42:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:42:28PM -0700, H. J. Lu wrote:
> In 2.5.70, intermezzo fs can be configured as module. But intermezzo
> references set_fs_root and set_fs_pwd:

I'd rather see a very good reason why intermezzo needs this first.


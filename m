Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVDHO1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVDHO1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVDHO1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:27:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38588 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262829AbVDHO1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:27:14 -0400
Date: Fri, 8 Apr 2005 15:27:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] Use proper seq_file api for /proc/scsi/scsi
Message-ID: <20050408142711.GA11172@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeremy Higdon <jeremy@sgi.com>, Hannes Reinecke <hare@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <42550173.1040503@suse.de> <20050407103123.GB9586@infradead.org> <425517B3.2010702@suse.de> <20050407112412.GA12072@infradead.org> <20050408072345.GA1018765@sgi.com> <20050408075643.GA5514@infradead.org> <20050408081011.GB1018765@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408081011.GB1018765@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 01:10:11AM -0700, Jeremy Higdon wrote:
> Just as a sanity check, you meant "lsscsi" and not "lssci" in your original
> reply, right?

Yes.


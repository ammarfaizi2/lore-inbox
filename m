Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbTGTNyL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbTGTNyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:54:10 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:60944 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267190AbTGTNyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:54:09 -0400
Date: Sun, 20 Jul 2003 15:09:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Charles E. Youse" <beef@nexuslabs.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, John Bradford <john@grabjohn.com>,
       lkml@lrsehosting.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030720150905.A12659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Charles E. Youse" <beef@nexuslabs.com>,
	Theodore Ts'o <tytso@mit.edu>, John Bradford <john@grabjohn.com>,
	lkml@lrsehosting.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
	Valdis.Kletnieks@vt.edu
References: <20030720000716.GA1085@think> <20030720092239.E75410-100000@treason.nexuslabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030720092239.E75410-100000@treason.nexuslabs.com>; from beef@nexuslabs.com on Sun, Jul 20, 2003 at 09:23:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 09:23:19AM -0400, Charles E. Youse wrote:
> My understanding is that theirs is a re-implementation of ext2, not a
> port.

There's large part taken directly from Linux but the higher level
parts are of course totally different.  Due to the GNU Obsfuc^H^H^H^H^HStyle
it's not easy to diff, though..


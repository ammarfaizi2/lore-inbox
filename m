Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbTFNFQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbTFNFQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:16:39 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:34471 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265617AbTFNFQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:16:38 -0400
Date: Sat, 14 Jun 2003 00:28:45 -0400
From: Ben Collins <bcollins@debian.org>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <20030614042845.GH492@hopper.phunnypharm.org>
References: <200306131453.h5DErX47015940@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306131453.h5DErX47015940@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 07:53:33AM -0700, Marcelo Tosatti wrote:
> final:
> 
> - 2.4.21-rc8 was released as 2.4.21 with no changes.

Could you atleast commit the EXTRAVERSION change and the v2.4.21 tag to
BK so that the CVS and subsequent users can be updated? I know it sounds
trivial, but some things eventually depend on it.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

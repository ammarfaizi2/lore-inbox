Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTIGWeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTIGWeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:34:05 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:36642 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261586AbTIGWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:34:03 -0400
Date: Sun, 7 Sep 2003 23:32:58 +0100
From: Dave Jones <davej@redhat.com>
To: DervishD <raul@pleyades.net>
Cc: Ch & Ph Drapela <pcdrap@bluewin.ch>, linux-kernel@vger.kernel.org
Subject: Re: Hardware supported by the kernel
Message-ID: <20030907223258.GE28927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	DervishD <raul@pleyades.net>, Ch & Ph Drapela <pcdrap@bluewin.ch>,
	linux-kernel@vger.kernel.org
References: <3F59DF81.8000407@bluewin.ch> <20030906134029.GE69@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030906134029.GE69@DervishD>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 03:40:29PM +0200, DervishD wrote:

 > > - an ATI Gapiccard
 >     I have an ATI card (128 LT Pro) and it's fully supported. IMHO
 > all ATI cards are.

Depends on your definition of 'supported'. Recent ATI cards[*] will
only work in accelerated 3d using their binary only driver.

		Dave

[*] Except the 9200

-- 
 Dave Jones     http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTENOla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTENOla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:41:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58785
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262416AbTENOl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:41:29 -0400
Subject: Re: supermount
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ismail donmez <kde@smtp-send.myrealbox.com>
Cc: gutko@poczta.onet.pl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052919666.273b9220kde@smtp-send.myrealbox.com>
References: <1052919666.273b9220kde@smtp-send.myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052920487.2491.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 14:54:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-14 at 14:41, ismail donmez wrote:
> Yeah I wonder the same for some time . Is there a good reason not to include supermount in kernel?

Its not considered of sufficient quality currently, and has or had races
that were not fixed. I'm sure Juan will submit it post 2.6 if he gets it
to a polished state


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUHDLme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUHDLme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUHDLme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:42:34 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:8860 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264346AbUHDLmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:42:33 -0400
Date: Wed, 4 Aug 2004 13:42:32 +0200
From: bert hubert <ahu@ds9a.nl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040804114232.GA23285@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <cone.1091614334.471559.9775.502@pc.kolivas.org> <4110BB88.3030400@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4110BB88.3030400@yahoo.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 08:33:44PM +1000, Nick Piggin wrote:

> >Well duh... disable interactivity and interactivity is bad. What's the 
> >problem? It's not meant to be used on a desktop in that way.
> 
> Well why would you want to disable it then?

When not on a desktop of course - most servers don't care about X
interactivity but do care a lot about 'nice', and would not want to grant a
process the CPU (unfairly) longer to satisfy the human need for snappy
responses.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJMJ1K>; Sun, 13 Oct 2002 05:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJMJ1K>; Sun, 13 Oct 2002 05:27:10 -0400
Received: from pD951B340.dip.t-dialin.net ([217.81.179.64]:10126 "EHLO
	lisa.wg.de") by vger.kernel.org with ESMTP id <S261476AbSJMJ1J>;
	Sun, 13 Oct 2002 05:27:09 -0400
Message-ID: <3DA93DC5.9050304@gmx.de>
Date: Sun, 13 Oct 2002 11:32:53 +0200
From: Constantin Loizides <consti75@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en, de, de-at, de-de, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.42 module tmscsi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am not able to compile the driver tmscsim.c
for my Tekram DC-390 adapter. It seems that
some porting from the 2.4.x kernels has to
be done (see scsiiom.c and Documentation/DMA
-mapping.txt). Is there someone working    
on that?      
If not, are there some good starting
points to do it myself?

       
Constantin



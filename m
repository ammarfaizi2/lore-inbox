Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUIMNN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUIMNN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUIMNN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:13:59 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:60842
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266679AbUIMNNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:13:49 -0400
Message-ID: <41459D0B.404@bio.ifi.lmu.de>
Date: Mon, 13 Sep 2004 15:13:47 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Unwritable device nodes on ro nfs
References: <200409131551.30187.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409131551.30187.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Hi,
> 
> I am moving away from devfs. I have a problem
> booting with ro nfs root fs.

Known problem and the patch is here:
http://linux.bkbits.net:8080/linux-2.6/cset@1.1803.129.187

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049


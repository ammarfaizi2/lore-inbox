Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSFKBtT>; Mon, 10 Jun 2002 21:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSFKBtT>; Mon, 10 Jun 2002 21:49:19 -0400
Received: from imsmq11.netvigator.com ([208.167.231.124]:58885 "HELO
	imsmq11.netvigator.com") by vger.kernel.org with SMTP
	id <S316535AbSFKBtR>; Mon, 10 Jun 2002 21:49:17 -0400
Message-ID: <3D05C721.9000409@iasystem.com>
Date: Tue, 11 Jun 2002 09:47:13 +0000
From: Banka <banka_peng@iasystem.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: zh, zh-tw, zh-cn, en-us
MIME-Version: 1.0
To: christoph@lameter.com
CC: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <Pine.LNX.4.33.0206100906030.29218-100000@melchi.fuller.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christoph@lameter.com wrote:

> Full symlink support. Yes, tar creates symlinks and the vfat fs makes .lnk
> files out of the symlinks. when ls displays the directory contents the
> vfat fs recognizes the .lnk files and tells the os that there is a
> symlink. Its fully transparent. The .lnk files are only visible
> under windoze.


the paths in windows looked like this:
		c:\folder\file

thus, under linux, all the links would be broken links anyway (and vice 
versa).


Banka.


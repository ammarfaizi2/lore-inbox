Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752048AbWIXDEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWIXDEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 23:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbWIXDEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 23:04:06 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:38347 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752048AbWIXDED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 23:04:03 -0400
Message-ID: <359067036.19509@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 24 Sep 2006 11:04:15 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: roland <devzero@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O statistics per process
Message-ID: <20060924030415.GA11861@mail.ustc.edu.cn>
Mail-Followup-To: roland <devzero@web.de>, linux-kernel@vger.kernel.org
References: <0e2001c6de7a$fe756280$962e8d52@aldipc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2001c6de7a$fe756280$962e8d52@aldipc>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 09:12:05PM +0200, roland wrote:
> is there a modified top/ps with i/o column, or is there yet missing 
> something at the kernel level for getting that counters from ?

Red Flag(http://www.redflag-linux.com/eindex.html) has developed an
iotop based on kprobes/systemtap. You can contact them if necessary.

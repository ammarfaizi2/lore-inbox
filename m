Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWDJSxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWDJSxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWDJSxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:53:22 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:19900 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932092AbWDJSxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:53:21 -0400
Date: Mon, 10 Apr 2006 21:53:13 +0300
From: Ville Herva <vherva@vianova.fi>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Black box flight recorder for Linux
Message-ID: <20060410185313.GP1686@vianova.fi>
Reply-To: vherva@vianova.fi
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it> <4437C335.30107@shaw.ca> <200604080917.39562.ak@suse.de> <4437E4B7.40208@superbug.co.uk> <slrne3ge8n.ps.mozbugbox@mozbugbox.somehost.org> <44393FD7.8080904@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44393FD7.8080904@superbug.co.uk>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Now, the question I have is, if I write values to RAM, do any of
> those values survive a reset?

I suppose this hasn't been mentioned in the thread yet -
apparently Philip Gladstone did such patch 7 years ago:

http://www.ussg.iu.edu/hypermail/linux/kernel/9906.3/1377.html
http://groups.google.com/groups?q=%22Utility+module+to+capture+OOPS+output+over+reboot%22&hl=en&selm=fa.fbd0l7v.14hau3n%40ifi.uio.no&rnum=1)


-- v -- 

v@iki.fi


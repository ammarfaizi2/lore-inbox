Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRJ3XyF>; Tue, 30 Oct 2001 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278803AbRJ3Xxy>; Tue, 30 Oct 2001 18:53:54 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:39879 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S278795AbRJ3Xxq>; Tue, 30 Oct 2001 18:53:46 -0500
Message-ID: <3BDF304F.80F88433@oracle.com>
Date: Tue, 30 Oct 2001 23:57:19 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre5-ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "P.Agenbag" <internet@psimation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13 kernel and ext3???
In-Reply-To: <3BDEE870.1060104@psimation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"P.Agenbag" wrote:
> 
[snip]
> upgrade to a newer version ( for one, I selected ext3 during install,
> yet, now trying to install 2.4.13, I must revert back to ext2...)

Moving back and forth between ext2 and ext3 works transparently,
 see the docs here:

http://www.uow.edu.au/~andrewm/linux/ext3/ext3-usage.html

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261564AbSJDL54>; Fri, 4 Oct 2002 07:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJDL54>; Fri, 4 Oct 2002 07:57:56 -0400
Received: from gw.openss7.com ([142.179.199.224]:14350 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261564AbSJDL5z>;
	Fri, 4 Oct 2002 07:57:55 -0400
Date: Fri, 4 Oct 2002 06:03:28 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: John Levon <levon@movementarian.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004060328.C13743@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de> <20021003235022.GA82187@compsoc.man.ac.uk> <mailman.1033691043.6446.linux-kernel2news@redhat.com> <200210040403.g9443Vu03329@devserv.devel.redhat.com> <20021003233221.C31444@openss7.org> <20021004114247.GA98207@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004114247.GA98207@compsoc.man.ac.uk>; from levon@movementarian.org on Fri, Oct 04, 2002 at 12:42:47PM +0100
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On Fri, 04 Oct 2002, John Levon wrote:

> 
> Look, why don't you submit the module-loading patch for LiS already ?
> 
> Btw, anybody know what the BKL is actually protecting against in
> sys_nfsservctl ?

Start of one earlier on thread without the BKL.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTAQMte>; Fri, 17 Jan 2003 07:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTAQMte>; Fri, 17 Jan 2003 07:49:34 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:48610
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S267330AbTAQMtd>; Fri, 17 Jan 2003 07:49:33 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: jdizzl@xs4all.nl
cc: linux-kernel@vger.kernel.org
Message-ID: <80256CB1.00474980.00@notesmta.eur.3com.com>
Date: Fri, 17 Jan 2003 12:58:10 +0000
Subject: Re: Detecting changes in a directory tree
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are a number of existing userland filesystems, try:

http://lufs.sourceforge.net/lufs/intro.html
"LUFS is a hybrid userspace filesystem framework supporting an indefinite number
of filesystems (localfs, sshfs, ftpfs, cardfs and cefs implemented so far)
transparently for any application."

http://uservfs.sourceforge.net/
"POrtable Dodgy Filesystems in Userland (hacK) version 2. Once upon a time,
there was project called podfuk. It used nfs, and nfs sucks. On one sunny night,
its author had nothing better to do, and he started creating fake cache manager
for coda. It worked in two days, and it worked pretty good. At least, ugly nfs
was gone."

http://hierfs.sourceforge.net/
"Welcome to the hierachical storage filesystem. This project aims to create a
simple way of managing a vast amount of data over multiple CD-R media. This is
done by creating a virtual filesystem simulating all files on the CDs as if they
were online on the harddisk. When a file is accessed, a dialog box asks for the
correct CD. So any program can be used to acces the data without needing to know
the files are on CD. "

http://vcfs.sourceforge.net/
"VCFS is the Virtual CVS FileSystem. VCFS provides a user-space NFS server that
allows local or remote CVS repositories to be mounted as a filesystem. It works
with existing CVS servers, including those used by SourceForge."

     Jon



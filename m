Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275042AbRJNK2P>; Sun, 14 Oct 2001 06:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275043AbRJNK2G>; Sun, 14 Oct 2001 06:28:06 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:11052 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S275042AbRJNK1u>; Sun, 14 Oct 2001 06:27:50 -0400
Posted-Date: Sun, 14 Oct 2001 10:27:56 GMT
Date: Sun, 14 Oct 2001 11:27:55 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 1.0.9 kernel release history
Message-ID: <Pine.LNX.4.21.0110131817520.21404-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

The following is the kernel release history for all kernels leading up
to the 1.0.9 kernel release, and summarises the first three and a half
years of kernel development nicely.

In developing this list, I discovered that several of the very early
release archives included large numbers of editor backup files, and
some of the release archives also included RCS revision control system
files. I very carefully pruned all of these from the directory trees
before producing the following table from the results thereof.

The columns are as follows:

 1. The modification date and time of the file with the most recent such
    time in the original tar archive, as extracted on a system set for
    Greenwich Mean Time (GMT).

 2. The number of lines of text in all documents that form part of the
    release archive. This includes not just the actual source code, but
    also all other documents found in the release archive.

 3. The size in bytes of the uncompressed release archive.

 4. The version number of the release in a standardised format. Several
    of the very early releases have different version numbers in the
    name of the release archive depending on where one gets the said
    release archive from, and do not contain any official version number
    within the archive itself, so the correct version number is very
    much open to question. I have tried to use a version number that is
    at least consistant with other version numbers from the same time
    period where this has happenned.

Best wishes from Riley.

==============================================================================

Date         Time      Document Lines  Tar File Size  Version
~~~~~~~~~~~  ~~~~~~~~  ~~~~~~~~~~~~~~  ~~~~~~~~~~~~~  ~~~~~~~
17 Sep 1991  17:29:55          10,239        235,669  0.01
 3 Dec 1991   1:48:02          13,460        307,481  0.10
 8 Dec 1991  18:37:16          13,839        319,681  0.11
16 Jan 1992   6:39:10          19,258        446,636  0.12

 8 Mar 1992  12:04:59          20,882        493,630  0.95
17 Mar 1992  21:47:55          21,275        503,578  0.95a
 9 Apr 1992  20:48:11          22,147        527,085  0.95c

22 Apr 1992   1:17:20          23,450        566,716  pre-0.96

22 May 1992  19:45:55          30,977        768,929  0.96a
22 Jun 1992   0:35:47          32,332        805,896  0.96b
24 Jun 1992   2:45:11          32,517        809,477  0.96b.1
26 Jun 1992  20:03:24          32,585        810,986  0.96b.2
 5 Jul 1992   1:15:12          35,785        909,913  0.96c
11 Jul 1992  20:16:04          36,419        927,811  0.96c.1
17 Jul 1992   4:30:30          38,912        999,795  0.96c.2

 1 Aug 1992  16:44:42          42,207      1,105,949  0.97
 6 Aug 1992   8:41:59          42,857      1,122,444  0.97.1
24 Aug 1992   1:42:12          43,556      1,140,106  0.97.2
 5 Sep 1992  22:30:37          46,062      1,213,309  0.97.3
 7 Sep 1992  15:51:11          46,101      1,213,942  0.97.4
12 Sep 1992  22:44:40          47,869      1,258,116  0.97.5
12 Sep 1992  22:44:40          47,869      1,258,116  0.97.5a
20 Sep 1992  19:11:29          48,123      1,258,409  0.97.6

29 Sep 1992  22:10:06          58,977      1,538,687  0.98
 5 Oct 1992  19:06:55          59,069      1,542,191  0.98.1
18 Oct 1992  14:12:03          66,770      1,744,902  0.98.2
27 Oct 1992  19:06:01          67,499      1,766,214  0.98.3
 9 Nov 1992   0:13:07          67,961      1,786,220  0.98.4
15 Nov 1992  18:21:27          68,566      1,805,696  0.98.5
 2 Dec 1992  19:59:00          76,343      2,040,244  0.98.6

13 Dec 1992  16:51:43          81,091      2,170,987  0.99
21 Dec 1992  20:47:43          81,775      2,190,747  0.99.1
 1 Jan 1993  21:47:31          81,981      2,197,087  0.99.2
13 Jan 1993  20:55:05          82,297      2,206,604  0.99.3
21 Jan 1993  20:14:37          82,422      2,209,965  0.99.4
 9 Feb 1993  20:09:10          81,586      2,086,403  0.99.5
22 Feb 1993  18:33:32          83,328      2,142,975  0.99.6
13 Mar 1993  17:46:43          91,195      2,353,720  0.99.7
22 Mar 1993  19:29:34          92,388      2,396,112  0.99.7a
 9 Apr 1993  16:03:38          93,103      2,416,715  0.99.8
24 Apr 1993   0:52:29          94,558      2,450,425  0.99.9
 7 Jun 1993  19:58:53         107,884      2,803,015  0.99.10
18 Jul 1993  19:19:42         113,845      2,981,653  0.99.11

15 Aug 1993  15:28:14         122,867      3,244,802  0.99.12
17 Aug 1993  22:39:38         122,871      3,244,979  0.99.12a

20 Sep 1993  16:18:01         124,228      3,279,890  0.99.13
25 Oct 1993  22:33:27         135,501      3,605,576  0.99.13k

29 Nov 1993   9:11:53         157,045      4,180,919  0.99.14
 3 Dec 1993  15:26:49         156,751      4,169,476  0.99.14a
 9 Dec 1993  10:56:12         156,789      4,169,595  0.99.14b
10 Dec 1993  14:29:01         156,802      4,169,759  0.99.14c
13 Dec 1993  11:01:47         157,229      4,180,077  0.99.14d
14 Dec 1993  10:43:29         157,652      4,191,831  0.99.14e
16 Dec 1993  12:27:40         157,631      4,190,578  0.99.14f
23 Dec 1993  11:51:31         164,547      4,387,230  0.99.14g
27 Dec 1993  13:22:44         164,443      4,384,843  0.99.14h
30 Dec 1993  13:17:23         164,693      4,388,856  0.99.14i
31 Dec 1993  10:01:44         165,093      4,401,306  0.99.14j
 3 Jan 1994  10:27:45         166,091      4,433,370  0.99.14k
 4 Jan 1994  12:26:13         166,094      4,433,295  0.99.14l
 5 Jan 1994  11:21:10         166,126      4,433,266  0.99.14m
 7 Jan 1994  14:50:53         171,556      4,553,257  0.99.14n
 8 Jan 1994  13:13:10         166,551      4,449,359  0.99.14o
13 Jan 1994  21:08:25         167,061      4,462,399  0.99.14p
17 Jan 1994  13:18:10         167,115      4,463,904  0.99.14q
18 Jan 1994  14:19:08         167,191      4,466,270  0.99.14r
19 Jan 1994  12:12:50         167,227      4,466,914  0.99.14s
21 Jan 1994  13:59:51         168,289      4,485,608  0.99.14t
25 Jan 1994   7:37:08         168,809      4,503,258  0.99.14u
26 Jan 1994  12:08:25         169,037      4,510,385  0.99.14v
27 Jan 1994  14:24:02         168,991      4,509,505  0.99.14w
29 Jan 1994  12:57:42         172,505      4,608,495  0.99.14x
 2 Feb 1994   6:45:07         173,152      4,629,797  0.99.14y
 2 Feb 1994  15:59:29         173,180      4,630,231  0.99.14z
 3 Feb 1994  13:14:03         173,251      4,633,162  0.99.15
 7 Feb 1994  14:58:39         173,279      4,634,200  0.99.15a
 9 Feb 1994  10:07:53         173,304      4,634,735  0.99.15b
13 Feb 1994  17:08:57         173,461      4,639,314  0.99.15c
14 Feb 1994  16:51:45         173,814      4,647,403  0.99.15d
16 Feb 1994  11:07:57         173,860      4,648,376  0.99.15e
18 Feb 1994  14:54:02         174,055      4,656,522  0.99.15f
21 Feb 1994  18:41:53         174,100      4,657,705  0.99.15g
22 Feb 1994  15:42:37         175,562      4,704,056  0.99.15h
 1 Mar 1994  17:29:05         175,630      4,706,122  0.99.15i
 2 Mar 1994  17:35:20         175,631      4,706,316  0.99.15j
 6 Mar 1994  16:14:51         175,631      4,705,912  pre-1.0

13 Mar 1994  22:38:57         176,250      4,719,743  1.0
16 Mar 1994  11:06:17         176,296      4,721,251  1.0.1
18 Mar 1994  10:31:01         176,314      4,721,959  1.0.2
21 Mar 1994  17:05:21         175,823      4,707,002  1.0.3
22 Mar 1994  16:54:31         175,822      4,706,929  1.0.4
28 Mar 1994  11:40:19         175,885      4,709,102  1.0.5
 3 Apr 1994  14:43:03         175,928      4,710,178  1.0.6
 6 Apr 1994  13:13:35         176,004      4,712,372  1.0.7
 7 Apr 1994   8:36:20         176,131      4,717,314  1.0.8
17 Apr 1994   0:17:39         176,140      4,717,507  1.0.9
~~~~~~~~~~~  ~~~~~~~~  ~~~~~~~~~~~~~~  ~~~~~~~~~~~~~  ~~~~~~~
Total: 96 kernels to date.

